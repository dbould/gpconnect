package uk.gov.hscic.appointments;

import ca.uhn.fhir.model.api.ExtensionDt;
import ca.uhn.fhir.model.dstu2.composite.CodeableConceptDt;
import ca.uhn.fhir.model.dstu2.composite.CodingDt;
import ca.uhn.fhir.model.dstu2.composite.IdentifierDt;
import ca.uhn.fhir.model.dstu2.composite.ResourceReferenceDt;
import ca.uhn.fhir.model.dstu2.resource.Appointment;
import ca.uhn.fhir.model.dstu2.resource.Appointment.Participant;
import ca.uhn.fhir.model.dstu2.resource.OperationOutcome;
import ca.uhn.fhir.model.dstu2.valueset.AppointmentStatusEnum;
import ca.uhn.fhir.model.dstu2.valueset.IssueSeverityEnum;
import ca.uhn.fhir.model.dstu2.valueset.ParticipationStatusEnum;
import ca.uhn.fhir.model.primitive.IdDt;
import ca.uhn.fhir.model.primitive.StringDt;
import ca.uhn.fhir.rest.annotation.Create;
import ca.uhn.fhir.rest.annotation.IdParam;
import ca.uhn.fhir.rest.annotation.OptionalParam;
import ca.uhn.fhir.rest.annotation.Read;
import ca.uhn.fhir.rest.annotation.RequiredParam;
import ca.uhn.fhir.rest.annotation.ResourceParam;
import ca.uhn.fhir.rest.annotation.Search;
import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.server.IResourceProvider;
import ca.uhn.fhir.rest.server.exceptions.InternalErrorException;
import ca.uhn.fhir.rest.server.exceptions.UnprocessableEntityException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import org.springframework.context.ApplicationContext;
import uk.gov.hscic.appointment.appointment.model.AppointmentDetail;
import uk.gov.hscic.appointment.appointment.search.AppointmentSearch;
import uk.gov.hscic.appointment.appointment.search.AppointmentSearchFactory;
import uk.gov.hscic.appointment.appointment.store.AppointmentStore;
import uk.gov.hscic.appointment.appointment.store.AppointmentStoreFactory;
import uk.gov.hscic.common.types.RepoSource;
import uk.gov.hscic.common.types.RepoSourceType;

public class AppointmentResourceProvider implements IResourceProvider {

    ApplicationContext applicationContext;

    public AppointmentResourceProvider(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }

    @Override
    public Class<Appointment> getResourceType() {
        return Appointment.class;
    }

    @Read()
    public Appointment getAppointmentById(@IdParam IdDt appointmentId) {

        RepoSource sourceType = RepoSourceType.fromString(null);
        AppointmentSearch appointmentSearch = applicationContext.getBean(AppointmentSearchFactory.class).select(sourceType);
        AppointmentDetail appointmentDetail = appointmentSearch.findAppointmentByID(appointmentId.getIdPartAsLong());

        if (appointmentDetail == null) {
            OperationOutcome operationalOutcome = new OperationOutcome();
            operationalOutcome.addIssue().setSeverity(IssueSeverityEnum.ERROR).setDetails("No appointment details found for ID: " + appointmentId.getIdPart());
            throw new InternalErrorException("No appointment details found for ID: " + appointmentId.getIdPart(), operationalOutcome);
        }
        
        return appointmentDetailToAppointmentResourceConverter(appointmentDetail);
    }
    
    @Search
    public List<Appointment> getAppointmentsForPatientId(@RequiredParam(name = "patientId") String patientId, @OptionalParam(name = "startDateTime") String startDateTime, @OptionalParam(name = "endDateTime") String endDateTime) {
        
        RepoSource sourceType = RepoSourceType.fromString(null);
        AppointmentSearch appointmentSearch = applicationContext.getBean(AppointmentSearchFactory.class).select(sourceType);
        ArrayList<Appointment> appointments = new ArrayList();

        List<AppointmentDetail> appointmentDetails = null;
        
        if(patientId != null && startDateTime != null && endDateTime != null){
            appointmentDetails = appointmentSearch.findAppointmentForPatientId(Long.valueOf(patientId), new Date(startDateTime), new Date(endDateTime));
        } else if(patientId != null && startDateTime != null){
            appointmentDetails = appointmentSearch.findAppointmentForPatientId(Long.valueOf(patientId), new Date(startDateTime));
        } else if(patientId != null){
            appointmentDetails = appointmentSearch.findAppointmentForPatientId(Long.valueOf(patientId));
        }   
        
        if (appointmentDetails != null && appointmentDetails.size() > 0) {
            for(AppointmentDetail appointmentDetail : appointmentDetails){
                appointments.add(appointmentDetailToAppointmentResourceConverter(appointmentDetail));
            }
        }
        
        return appointments;
    }
    
    @Create
    public MethodOutcome createPatient(@ResourceParam Appointment appointment) {

        if (appointment.getStatus().isEmpty()) {
            throw new UnprocessableEntityException("No status supplied");
        }
        if (appointment.getReason() == null) {
            throw new UnprocessableEntityException("No reason supplied");
        }
        if (appointment.getStart()== null || appointment.getEnd() == null) {
            throw new UnprocessableEntityException("Both start and end date are required");
        }
        if (appointment.getParticipant().size() <= 0) {
            throw new UnprocessableEntityException("Atleast one participant is required");
        }

        // Store New Appointment
        AppointmentDetail appointmentDetail = appointmentResourceConverterToAppointmentDetail(appointment);
        
        RepoSource sourceType = RepoSourceType.fromString(null);
        AppointmentStore appointmentStore = applicationContext.getBean(AppointmentStoreFactory.class).select(sourceType);
        appointmentDetail = appointmentStore.saveAppointment(appointmentDetail);
                
        // Build response containing the new resource id
        MethodOutcome methodOutcome = new MethodOutcome();
        methodOutcome.setId(new IdDt("Appointment", appointmentDetail.getId()));

        return methodOutcome;
    }

    public Appointment appointmentDetailToAppointmentResourceConverter(AppointmentDetail appointmentDetail){
        
        Appointment appointment = new Appointment();
        appointment.setId(String.valueOf(appointmentDetail.getId()));
        appointment.addUndeclaredExtension(true, "http://fhir.nhs.net/StructureDefinition/extension-gpconnect-appointment-cancellation-reason-1-0", new StringDt(appointmentDetail.getCancellationReason()));
        appointment.setIdentifier(Collections.singletonList(new IdentifierDt("http://fhir.nhs.net/Id/gpconnect-appointment-identifier", String.valueOf(appointmentDetail.getId()))));
        
        switch(appointmentDetail.getStatus().toLowerCase()){
            case "pending" : appointment.setStatus(AppointmentStatusEnum.PENDING); break;
            case "booked" : appointment.setStatus(AppointmentStatusEnum.BOOKED); break;
            case "arrived" : appointment.setStatus(AppointmentStatusEnum.ARRIVED); break;
            case "fulfilled" : appointment.setStatus(AppointmentStatusEnum.FULFILLED); break;
            case "cancelled" : appointment.setStatus(AppointmentStatusEnum.CANCELLED); break;
            case "noshow" : appointment.setStatus(AppointmentStatusEnum.NO_SHOW); break;
            default : appointment.setStatus(AppointmentStatusEnum.PENDING); break;
        }
        
        CodingDt coding = new CodingDt().setSystem("http://hl7.org/fhir/ValueSet/c80-practice-codes").setCode(String.valueOf(appointmentDetail.getTypeCode())).setDisplay(appointmentDetail.getTypeDisplay());
        CodeableConceptDt codableConcept = new CodeableConceptDt().addCoding(coding);
        codableConcept.setText(appointmentDetail.getTypeDisplay());
        appointment.setType(codableConcept);
        
        CodingDt codingReason = new CodingDt().setSystem("http://snomed.info/sct").setCode(String.valueOf(appointmentDetail.getReasonCode())).setDisplay(appointmentDetail.getReasonDisplay());
        CodeableConceptDt codableConceptReason = new CodeableConceptDt().addCoding(codingReason);
        codableConceptReason.setText(appointmentDetail.getReasonDisplay());
        appointment.setReason(codableConceptReason);
        
        appointment.setStartWithMillisPrecision(appointmentDetail.getStartDateTime());
        appointment.setEndWithMillisPrecision(appointmentDetail.getEndDateTime());
        appointment.setSlot(Collections.singletonList(new ResourceReferenceDt("Slot/"+appointmentDetail.getSlotId())));
        appointment.setComment(appointmentDetail.getComment());
        
        Participant patientParticipant = appointment.addParticipant();
        patientParticipant.setActor(new ResourceReferenceDt("Patient/"+appointmentDetail.getPatientId()));
        patientParticipant.setStatus(ParticipationStatusEnum.ACCEPTED);
        
        Participant practitionerParticipant = appointment.addParticipant();
        practitionerParticipant.setActor(new ResourceReferenceDt("Practitioner/"+appointmentDetail.getPractitionerId()));
        practitionerParticipant.setStatus(ParticipationStatusEnum.ACCEPTED);
        
        Participant locationParticipant = appointment.addParticipant();
        locationParticipant.setActor(new ResourceReferenceDt("Location/"+appointmentDetail.getLocationId()));
        locationParticipant.setStatus(ParticipationStatusEnum.ACCEPTED);
        
        return appointment;
    }
    
    public AppointmentDetail appointmentResourceConverterToAppointmentDetail(Appointment appointment){
        
        AppointmentDetail appointmentDetail = new AppointmentDetail();
        appointmentDetail.setId(appointment.getId().getIdPartAsLong());
        
        List<ExtensionDt> extension = appointment.getUndeclaredExtensionsByUrl("http://fhir.nhs.net/StructureDefinition/extension-gpconnect-appointment-cancellation-reason-1-0");
        if(extension != null && extension.size() > 0){
            String cancellationReason = extension.get(0).getValue().toString();
            appointmentDetail.setCancellationReason(cancellationReason);
        }
        
        appointmentDetail.setStatus(appointment.getStatus().toLowerCase());
        appointmentDetail.setTypeCode(Long.valueOf(appointment.getType().getCodingFirstRep().getCode()));
        appointmentDetail.setTypeDisplay(appointment.getType().getCodingFirstRep().getDisplay());
        appointmentDetail.setReasonCode(appointment.getReason().getCodingFirstRep().getCode());
        appointmentDetail.setReasonDisplay(appointment.getReason().getCodingFirstRep().getDisplay());
        appointmentDetail.setStartDateTime(appointment.getStart());
        appointmentDetail.setEndDateTime(appointment.getEnd());
        appointmentDetail.setSlotId(appointment.getSlot().get(0).getReference().getIdPartAsLong());
        appointmentDetail.setComment(appointment.getComment());
        
        for(Appointment.Participant participant : appointment.getParticipant()){
            if(participant.getActor() != null){
                String participantReference = participant.getActor().getReference().getValue();
                Long actorId = Long.valueOf(participantReference.substring(participantReference.lastIndexOf("/") + 1));
                if(participantReference.contains("Patient/")) appointmentDetail.setPatientId(actorId);
                else if(participantReference.contains("Practitioner/")) appointmentDetail.setPractitionerId(actorId);
                else if(participantReference.contains("Location/")) appointmentDetail.setLocationId(actorId);
            }
        }
        
        return appointmentDetail;
    }
}