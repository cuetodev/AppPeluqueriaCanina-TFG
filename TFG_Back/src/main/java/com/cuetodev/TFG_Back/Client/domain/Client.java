package com.cuetodev.TFG_Back.Client.domain;

import com.cuetodev.TFG_Back.Pet.domain.Pet;
import com.sun.istack.NotNull;
import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Set;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Client {
    // todo insertar número de teléfono
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private Integer clientId;

    @NotNull
    @Size(min = 3, max = 20)
    private String userName;

    @NotNull
    private String email;

    @NotNull
    private String password;

    @NotNull
    private String role;

    @NotNull
    private Boolean active;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "client")
    private Set<Pet> pets;
}
