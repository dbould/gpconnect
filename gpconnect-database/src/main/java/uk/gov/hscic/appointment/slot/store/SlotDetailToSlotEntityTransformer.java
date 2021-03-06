package uk.gov.hscic.appointment.slot.store;

import org.apache.commons.collections4.Transformer;
import uk.gov.hscic.appointment.appointment.model.AppointmentEntity;
import uk.gov.hscic.appointment.slot.model.SlotDetail;
import uk.gov.hscic.appointment.slot.model.SlotEntity;

public class SlotDetailToSlotEntityTransformer implements Transformer<SlotDetail, SlotEntity> {

    @Override
    public SlotEntity transform(SlotDetail item) {
        SlotEntity slotEntity = new SlotEntity();
        slotEntity.setId(item.getId());

        if (item.getAppointmentId() != null) {
            AppointmentEntity appointment = new AppointmentEntity();
            appointment.setId(item.getAppointmentId());
            slotEntity.setAppointmentId(appointment);
        }

        slotEntity.setTypeCode(item.getTypeCode());
        slotEntity.setTypeDisply(item.getTypeDisply());
        slotEntity.setScheduleReference(item.getScheduleReference());
        slotEntity.setFreeBusyType(item.getFreeBusyType());
        slotEntity.setStartDateTime(item.getStartDateTime());
        slotEntity.setEndDateTime(item.getEndDateTime());
        slotEntity.setLastUpdated(item.getLastUpdated());
        return slotEntity;
    }

}
