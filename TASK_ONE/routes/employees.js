const express = require('express');
const route = express.Router();
const EmployeeController = require('../controllers/EmployeeController');

route.get('/ArrangeFiles', EmployeeController.ArrageEmplyeeFiles);


module.exports = route;
