import {Request, Response} from "express";

export class UsersController {
    constructor (){};

    private errorHandling = (err: unknown, res: Response) => {
        console.log(err);
        res.status(500).json({ message: err })
    }

    getUsers = async(req:Request, res:Response) => {
        try{
            res.json({success: 'ts call success', url: req.url});
        }catch(err){
            this.errorHandling(err, res);
        };
    };

}