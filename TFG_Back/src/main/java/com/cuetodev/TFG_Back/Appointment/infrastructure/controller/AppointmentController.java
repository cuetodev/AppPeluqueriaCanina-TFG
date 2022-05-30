package com.cuetodev.TFG_Back.Appointment.infrastructure.controller;


import com.cuetodev.TFG_Back.Appointment.application.port.AppointmentPort;
import com.cuetodev.TFG_Back.Appointment.domain.Appointment;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input.AppointmentInputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input.AppointmentUpdateInputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.output.AppointmentOutputDTO;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.output.PetOutputDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("api/v0/appointment")
public class AppointmentController {

    @Autowired
    AppointmentPort appointmentPort;

    /*
    * ------------------ ------ ------------------
    *                    CREATE
    * ------------------ ------ ------------------
    */

    @PostMapping
    public ResponseEntity<?> createAppointment (@RequestBody @Valid AppointmentInputDTO appointmentInputDTO) throws ParseException {
        Appointment finalAppointment = appointmentPort.createAppointment(appointmentInputDTO);
        return new ResponseEntity<>(new AppointmentOutputDTO(finalAppointment), HttpStatus.OK);
    }

    /*
     * ------------------ ---- ------------------
     *                    READ
     * ------------------ ---- ------------------
     */

    @GetMapping("/all")
    public ResponseEntity<?> findAppointmentsByConditions(
            @RequestParam(required = false, defaultValue = "0") int page,
            @RequestParam(required = false, defaultValue = "10") int size,
            @RequestParam(required = false, defaultValue = "active") String status,
            @RequestParam(required = false, defaultValue = "noDate") String lowerDate,
            @RequestParam(required = false, defaultValue = "noDate") String upperDate,
            @RequestParam(required = false, defaultValue = "noDate") String equalDate) {

        HashMap<String, Object> conditions = new HashMap<>();
        conditions.put("status", status);
        conditions.put("lowerDate", lowerDate);
        conditions.put("upperDate", upperDate);
        conditions.put("equalDate", equalDate);

        Page<AppointmentOutputDTO> checkedAppointments = appointmentPort.findAppointmentsByConditions(conditions, page, size);
        return new ResponseEntity<>(checkedAppointments, HttpStatus.OK);
    }

    @GetMapping("{id}")
    public ResponseEntity<?> findByID(@PathVariable Integer id) {
        Appointment appointment = appointmentPort.findByID(id);
        return new ResponseEntity<>(new AppointmentOutputDTO(appointment), HttpStatus.OK);
    }

    /*
     * ------------------ ------ ------------------
     *                    UPDATE
     * ------------------ ------ ------------------
     */

    @PutMapping("{id}")
    public ResponseEntity<?> updateAppointment(@PathVariable Integer id,
                                               @RequestBody AppointmentUpdateInputDTO appointmentUpdateInputDTO) throws ParseException {
        Appointment updatedAppointment = appointmentPort.updateAppointment(id, appointmentUpdateInputDTO);
        return new ResponseEntity<>(new AppointmentOutputDTO(updatedAppointment), HttpStatus.OK);
    }

    /*
     * ------------------ ------ ------------------
     *                    DELETE
     * ------------------ ------ ------------------
     */

    @DeleteMapping("{id}")
    public ResponseEntity<?> deleteAppointment(@PathVariable Integer id) {
        appointmentPort.deleteAppointment(id);
        return new ResponseEntity<>("", HttpStatus.OK);
    }

}
