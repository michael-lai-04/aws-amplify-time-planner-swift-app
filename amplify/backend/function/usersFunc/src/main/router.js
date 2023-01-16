"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.usersRoutes = void 0;
const express_1 = __importDefault(require("express"));
const app_1 = require("../app");
exports.usersRoutes = express_1.default.Router();
exports.usersRoutes.get("/users", app_1.usersFuncController.getUsers);
