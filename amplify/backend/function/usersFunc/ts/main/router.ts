import express from "express";
import {usersFuncController} from "../app";

export const usersRoutes = express.Router();

usersRoutes.get("/users",usersFuncController.getUsers);