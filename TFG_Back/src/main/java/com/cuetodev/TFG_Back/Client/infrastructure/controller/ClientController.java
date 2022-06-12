package com.cuetodev.TFG_Back.Client.infrastructure.controller;

import com.cuetodev.TFG_Back.Client.application.port.ClientPort;
import com.cuetodev.TFG_Back.Client.domain.Client;
import com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.input.ClientEmailInputDTO;
import com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.input.ClientInputDTO;
import com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.input.ClientUpdateInputDTO;
import com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.output.ClientOutputDTO;
import com.cuetodev.TFG_Back.shared.ErrorHandling.ErrorOutputDTO;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("api/v0/client")
public class ClientController {

    @Autowired
    ClientPort clientPort;

    /*
    * ------------------ ------ ------------------
    *                    CREATE
    * ------------------ ------ ------------------
    */

    @PostMapping
    public ResponseEntity<?> registerClient(@RequestBody @Valid ClientInputDTO clientInputDTO) {
        // First I transform my DTO into my model
        Client client = clientInputDTO.convertEntityToDTO();
        Client checkedClient = clientPort.checkAndSave(client);
        return new ResponseEntity<>(new ClientOutputDTO(checkedClient), HttpStatus.OK);
    }

    /*
     * ------------------ ---- ------------------
     *                    READ
     * ------------------ ---- ------------------
     */

    @GetMapping("/login")
    public ResponseEntity<?> login(@RequestParam String email,
                                   @RequestParam String password) {
        Client checkedClient = clientPort.findClientByEmailAndPasswordAndActive(email, password);
        return new ResponseEntity<>(new ClientOutputDTO(checkedClient), HttpStatus.OK);
    }

    @GetMapping("{id}")
    public ResponseEntity<?> findClientById(@PathVariable Integer id) {
        Client checkedClient;
        checkedClient = clientPort.findClientById(id);
        return new ResponseEntity<>(new ClientOutputDTO(checkedClient), HttpStatus.OK);
    }

    @PostMapping("/email")
    public ResponseEntity<?> findClientByEmail(@RequestBody @Valid ClientEmailInputDTO clientEmailInputDTO) {
        String email = clientEmailInputDTO.getEmail();
        if (email == null) throw new ErrorOutputDTO("Email cannot be null");
        if (email.length() == 0) throw new ErrorOutputDTO("Email cannot be empty");
        Client checkedClient = clientPort.findClientByEmail(email);
        return new ResponseEntity<>(new ClientOutputDTO(checkedClient), HttpStatus.OK);
    }

    @GetMapping("/userName")
    public ResponseEntity<?> findClientsByUserName(@RequestParam String userName,
                                                   @RequestParam(required = false, defaultValue = "0") int page,
                                                   @RequestParam(required = false, defaultValue = "10") int size) {
        Page<ClientOutputDTO> checkedClients = clientPort.findClientsByUserName(userName, page, size);
        return new ResponseEntity<>(checkedClients, HttpStatus.OK);
    }

    @GetMapping("/all")
    public ResponseEntity<?> findAllClients(@RequestParam(required = false, defaultValue = "0") int page,
                                            @RequestParam(required = false, defaultValue = "10") int size) {
        Page<ClientOutputDTO> checkedClients = clientPort.findAllClients(page, size);
        return new ResponseEntity<>(checkedClients, HttpStatus.OK);
    }

    /*
     * ------------------ ------ ------------------
     *                    UPDATE
     * ------------------ ------ ------------------
     */

    @PutMapping("{id}")
    public ResponseEntity<?> updateClient(@PathVariable Integer id,
                                          @RequestBody ClientUpdateInputDTO clientInputDTO) {
        Client updatedClient = clientPort.updateClient(id, clientInputDTO);
        return new ResponseEntity<>(new ClientOutputDTO(updatedClient), HttpStatus.OK);
    }

    /*
     * ------------------ ------ ------------------
     *                    DELETE
     * ------------------ ------ ------------------
     */

    @DeleteMapping("{id}")
    public ResponseEntity<?> deleteClient(@PathVariable Integer id) {
        clientPort.deleteClient(id);
        return new ResponseEntity<>("", HttpStatus.OK);
    }

    /*
     * ------------------ --- ------------------
     *                    JWT
     * ------------------ --- ------------------
     */

    @GetMapping("/token")
    public ResponseEntity<?> getToken(@RequestParam String email,
                                      @RequestParam String password) {
        Client clientWantedToFind = clientPort.findClientByEmailAndPassword(email, password);

        if (clientWantedToFind == null) return new ResponseEntity<>("", HttpStatus.FORBIDDEN);
        if (!clientWantedToFind.getEmail().trim().equals(email) || !clientWantedToFind.getPassword().equals(password))
            return new ResponseEntity<>("", HttpStatus.FORBIDDEN);

        String rol = clientWantedToFind.getRole().toUpperCase().trim();
        return new ResponseEntity<>(getJWTToken(email, rol), HttpStatus.OK);
    }

    private String getJWTToken(String email, String rol) {
        String secretKey = "mySecretKey";
        List<GrantedAuthority> grantedAuthorities = AuthorityUtils
                .commaSeparatedStringToAuthorityList("ROLE_USER");

        String token = Jwts
                .builder()
                .setId("softtekJWT")
                .setSubject(email)
                .claim("authorities",
                        grantedAuthorities.stream()
                                .map(GrantedAuthority::getAuthority)
                                .collect(Collectors.toList()))
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .signWith(SignatureAlgorithm.HS512,
                        secretKey.getBytes()).compact();

        return "Bearer " + token;
    }

}
