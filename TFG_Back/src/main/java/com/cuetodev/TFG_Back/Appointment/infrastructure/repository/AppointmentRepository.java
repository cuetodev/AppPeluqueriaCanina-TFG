package com.cuetodev.TFG_Back.Appointment.infrastructure.repository;

import com.cuetodev.TFG_Back.Appointment.domain.Appointment;
import com.cuetodev.TFG_Back.Appointment.infrastructure.repository.jpa.AppointmentRepositoryJPA;
import com.cuetodev.TFG_Back.Appointment.infrastructure.repository.port.AppointmentRepositoryPort;
import com.cuetodev.TFG_Back.shared.ErrorHandling.ErrorOutputDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class AppointmentRepository implements AppointmentRepositoryPort {

    @Autowired
    AppointmentRepositoryJPA appointmentRepositoryJPA;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Appointment createAppointment(Appointment appointment) {
        return appointmentRepositoryJPA.save(appointment);
    }

    @Override
    public List<Appointment> findAppointmentsByConditions(HashMap<String, Object> conditions) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Appointment> query= cb.createQuery(Appointment.class);
        Root<Appointment> root = query.from(Appointment.class);
        List<Predicate> predicates = new ArrayList<>();

        conditions.forEach((field,value) ->
        {
            switch (field)
            {
                case "status":
                    predicates.add(cb.like(root.<String>get("status"), (String) value));
                    break;
                case "lowerDate":
                    if (!value.equals("noDate")) {
                        Date lowerDate;
                        try {
                            lowerDate = new SimpleDateFormat("yyyy-MM-dd").parse((String) value);
                        } catch (ParseException e) {
                            throw new ErrorOutputDTO("Invalid date format");
                        }
                        predicates.add(cb.greaterThan(root.<Date>get("date"), lowerDate));
                    }
                    break;
                case "upperDate":
                    if (!value.equals("noDate")) {
                        Date upperDate;
                        try {
                            upperDate = new SimpleDateFormat("yyyy-MM-dd").parse((String) value);
                        } catch (ParseException e) {
                            throw new ErrorOutputDTO("Invalid date format");
                        }
                        predicates.add(cb.lessThan(root.<Date>get("date"),upperDate));
                        break;
                    }
                    break;
                case "equalDate":
                    if (!value.equals("noDate")) {
                        Date equalDate;
                        try {
                            equalDate = new SimpleDateFormat("yyyy-MM-dd").parse((String) value);
                        } catch (ParseException e) {
                            throw new ErrorOutputDTO("Invalid date format");
                        }
                        predicates.add(cb.equal(root.get("date"), equalDate));
                    }
                    break;
            }
        });
        query.select(root).where(predicates.toArray(new Predicate[0]));

        return entityManager.createQuery(query).getResultList();
    }

    @Override
    public Appointment findByID(Integer id) {
        Appointment appointment = appointmentRepositoryJPA.findById(id).orElse(null);
        if (appointment == null) throw new ErrorOutputDTO("Appointment not found");
        return appointment;
    }

    @Override
    public void deleteAppointment(Appointment appointment) {
        appointmentRepositoryJPA.delete(appointment);
    }
}
