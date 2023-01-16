import AWS from 'aws-sdk';
import express from 'express';
import bodyParser from 'body-parser';
import awsServerlessExpressMiddleware from 'aws-serverless-express/middleware';

AWS.config.update({ region: "ap-northeast-1" });

// declare a new express app
const app = express()
app.use(bodyParser.json())
app.use(awsServerlessExpressMiddleware.eventContext())

// Enable CORS for all methods
app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*")
    res.header("Access-Control-Allow-Headers", "*")
    next()
});

app.listen(3000, function() {
    console.log("App started")
});

import {UsersController} from "./main/controller";
export const usersFuncController = new UsersController();
 
import {usersRoutes} from "./main/router";
app.use(usersRoutes)

// Export the app object. When executing the application local this does nothing. However,
// to port it to AWS Lambda we will create a wrapper around that will load the app from
// this file
module.exports = app
