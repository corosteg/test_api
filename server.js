const bodyParser = require('body-parser');
const cors = require('cors');
const app = require('express')();


app.use(cors());

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
 
// parse application/json
app.use(bodyParser.json())


app.post('/notify', (req, res) => {
    console.log('body => ', req.body);
    res.json({ data: req.body });
});

app.listen(process.env.PORT || 9000);