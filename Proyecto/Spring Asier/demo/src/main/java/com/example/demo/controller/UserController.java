package com.example.demo.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.demo.dto.UserDTO;
import com.example.demo.interfaces.IController;
import com.example.demo.model.USUARIO;
import com.example.demo.service.UserService;

@RestController
@RequestMapping("/UserController")
public class UserController implements IController<UserDTO> {

    @Autowired
    UserService service;

    @GetMapping("/GetAllUsers")
    public ResponseEntity<List<USUARIO>> getAll() {
        return new ResponseEntity<>(service.gettAll(), HttpStatus.OK);
    }

    @GetMapping("/GetUser")
    @Override
    public ResponseEntity<UserDTO> getMethod(UserDTO bean) {

        return new ResponseEntity<>(null, HttpStatus.OK);
    }

    @PostMapping("/PostUser")
    @Override
    public ResponseEntity<UserDTO> postMethod(UserDTO bean) {

        return new ResponseEntity<>(null, HttpStatus.OK);

    }

    @PutMapping("/PutUser/{id}")
    @Override
    public ResponseEntity<UserDTO> putMethod(UserDTO bean) {

        return new ResponseEntity<>(null, HttpStatus.OK);
    }

    @DeleteMapping("/DeleteUser/{id}")
    @Override
    public void deleteMethod(UserDTO bean) {
    }

}
