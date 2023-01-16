"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsersController = void 0;
class UsersController {
    constructor() {
        this.errorHandling = (err, res) => {
            console.log(err);
            res.status(500).json({ message: err });
        };
        this.getUsers = async (req, res) => {
            try {
                res.json({ success: 'ts call success', url: req.url });
            }
            catch (err) {
                this.errorHandling(err, res);
            }
            ;
        };
    }
    ;
}
exports.UsersController = UsersController;
