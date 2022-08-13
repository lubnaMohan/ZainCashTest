const express = require('express')
const employeeRouter = require('./routes/employees'); 
const app = express()
const port = 3000

app.use('/Emplyee', employeeRouter);

app.listen(port, () => {
  console.log(`TASK ONE APP IS LISTENING ON PORT ${port}`)
})