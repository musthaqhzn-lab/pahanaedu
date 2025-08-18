package com.icbt.service;

import com.icbt.model.User;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class UserServiceTest {

    @Test
    void testLoginWithValidCredentials() {
        UserService userService = new UserService();
        String validUsername = "admin";
        String validPassword = "admin@123";

        User user = userService.login(validUsername, validPassword);
        assertNotNull(user, "User should not be null with valid credentials");
        assertEquals(validUsername, user.getUsername(), "Username should match");
    }

    @Test
    void testLoginWithInvalidCredentials() {
        UserService userService = new UserService();
        String invalidUsername = "wronguser";
        String invalidPassword = "wrongpass";

        User user = userService.login(invalidUsername, invalidPassword);
        assertNull(user, "User should be null with invalid credentials");
    }
}
