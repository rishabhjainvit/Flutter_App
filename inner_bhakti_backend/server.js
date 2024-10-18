const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const dotenv = require('dotenv');


dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());


console.log('MongoDB URI:', process.env.MONGO_URI);


mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => {
  console.log('Connected to MongoDB');
}).catch((err) => {
  console.error('Failed to connect to MongoDB:', err);
});


const ProgramSchema = new mongoose.Schema({
  title: String,
  image: String,
  details: [String],
  audioUrl: String,
});

const Program = mongoose.model('Program', ProgramSchema);


app.get('/programs', async (req, res) => {
  try {
    const programs = await Program.find();
    res.json(programs);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching programs' });
  }
});


app.get('/programs/:id', async (req, res) => {
  try {
    const program = await Program.findById(req.params.id);
    res.json(program);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching program' });
  }
});


app.get('/audio/:id', async (req, res) => {
  try {
    const program = await Program.findById(req.params.id);
    res.json({ audioUrl: program.audioUrl });
  } catch (err) {
    res.status(500).json({ message: 'Error fetching audio' });
  }
});


app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
