package com.cuetodev.TFG_Back.Pet.domain;

import com.cuetodev.TFG_Back.Appointment.domain.Appointment;
import com.cuetodev.TFG_Back.Client.domain.Client;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Set;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Pet {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private Integer petId;

    @NotNull
    @Size(max = 20)
    private String name;

    @NotNull
    @Size(max = 150)
    private String breed;

    @NotNull
    private String type;

    private Float weight;

    private String img;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client_id")
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
    private Client client;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "pet")
    private Set<Appointment> appointments;
}
