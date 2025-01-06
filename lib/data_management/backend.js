const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

mongo_url = ''

// Connecting to MongoDB
mongoose.connect(mongo_url, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

const dataSchema = new mongoose.Schema({
    name: String,
    value: Number,
});

const Data = mongoose.model('Data', dataSchema);

// Fetching data
app.get('/data', async (req, res) => {
    try {
        const data = await Data.find();
        res.json(data);
    } catch (err) {
        res.status(500).send(err.message);
    }
});

const PORT = 5000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
