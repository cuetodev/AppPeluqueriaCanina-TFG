package com.cuetodev.TFG_Back;

import com.cuetodev.TFG_Back.Client.application.port.ClientPort;
import com.cuetodev.TFG_Back.Client.domain.Client;
import com.cuetodev.TFG_Back.Pet.domain.Pet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.HashSet;
import java.util.Set;

@SpringBootApplication
public class TfgBackApplication {

	public static void main(String[] args) {
		SpringApplication.run(TfgBackApplication.class, args);
	}

	@Autowired
	ClientPort clientPort;

	// Only for testing
	@Bean
	CommandLineRunner creatingTestClients() {
		return p -> {
			Client checkNormalClient = clientPort.findClientByEmailAndPassword("u@u.es", "u");
			Client checkWorkerClient = clientPort.findClientByEmailAndPassword("w@w.es", "w");
			Client checkAdminClient = clientPort.findClientByEmailAndPassword("a@a.es", "a");

			if (checkNormalClient == null) {
				Client normalClient = new Client(null, "Usuario", "u@u.es", "u", "ROLE_USER", true, new HashSet<>());
				clientPort.saveClient(normalClient);
			}

			if (checkWorkerClient == null) {
				Client workerClient = new Client(null, "Trabajador", "w@w.es", "w", "ROLE_WORKER", true, new HashSet<>());
				clientPort.saveClient(workerClient);
			}

			if (checkAdminClient == null) {
				Client adminClient = new Client(null, "Administrador", "a@a.es", "a", "ROLE_ADMIN", true, new HashSet<>());
				clientPort.saveClient(adminClient);
			}
		};
	}

}
