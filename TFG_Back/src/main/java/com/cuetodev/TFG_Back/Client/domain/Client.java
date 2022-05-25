package com.cuetodev.TFG_Back.Client.domain;

import com.sun.istack.NotNull;
import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Client {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private Integer id;

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
}
