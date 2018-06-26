var express = require("express"); //to initiate the express module

var app = express(); //to call the module

/*app.get('/', (req, res) => res.send('Hello World!'))

app.listen(3000, () => console.log('Node.js app listening on port 3000.'))

*/
///////////////////////OR, I also tried this/////////////////////////////


app.get('/', function(req, res) {   //if somebody opens up the root of the webpage, we want to show him a hellow world message, using a callback with 2 parameters and we just send a basic text response.
    res.send("Hello world by using my option 2.\n")
});

app.listen(3000, function() {
    console.log("Node.js app is runnig and listening on port 3000");
});

