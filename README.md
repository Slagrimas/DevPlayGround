## 30 Days of API - [API Playground](http://playground.baseem.me/).

[![IBM](https://img.shields.io/badge/IBM-API-blue.svg)](https://www.ibm.com/watson/developercloud/personality-insights/api/v3/) [![AWS](https://img.shields.io/badge/AWS-API-blue.svg)](https://aws.amazon.com/rekognition/) [![BUS](https://img.shields.io/badge/DABUS-API-blue.svg)](http://hea.thebus.org/api_info.asp) [![GOOGLE](https://img.shields.io/badge/GOOGLE-API-blue.svg)](https://cloud.google.com/translate/) [![YELP](https://img.shields.io/badge/YELP-API-blue.svg)](https://www.yelp.com/fusion) [![ARCHIVE](https://img.shields.io/badge/ARCHIVE-API-blue.svg)](https://archive.org/) [![GIPHY](https://img.shields.io/badge/GIPHY-API-blue.svg)](https://developers.giphy.com/docs/) [![BPM](https://img.shields.io/badge/BPM-API-blue.svg)](https://getsongbpm.com/api) [![TMDB](https://img.shields.io/badge/TMDB-API-blue.svg)](https://www.themoviedb.org/documentation/api)




This Web-App will include a library of API samples - to make it easier when working with the varios API's available.

Including Code Samples, Demo Sites, and video tutorials.

Below are examples for getting started with the different API's:

## Emotional API - [IBM WATSON](https://www.ibm.com/watson/developercloud/personality-insights/api/v3/) - AUTH

```js
const baseem = require('baseem');
const PersonalityInsightsV3 = require('watson-developer-cloud/personality-insights/v3');
const personality_insights = new PersonalityInsightsV3({
  username: process.env.IBM_USERNAME,
  password: process.env.IBM_PASSWORD,
  version_date: process.env.IBM_VERSIONDATE,
  headers: {
    'X-Watson-Learning-Opt-Out': 'true'
  }
});

app.post('/', (req,res) => {
  var text = req.body.text;
  personality_insights.profile(
  {text: text},
  function (err, response) {
    if (err)
      res.status(404).json({error: err});
    else
      res.json(response);
  });
});
```

## Conversation API - [IBM WATSON](https://www.ibm.com/watson/developercloud/personality-insights/api/v3/) - AUTH

```js
const ConversationV1 = require('watson-developer-cloud/conversation/v1');
const conversation = new ConversationV1(config.conversParams);
const workspace_id = process.env.IBM_WORKSPACEID;
const baseem = require('baseem');

app.post('/', (req,res) => {
  var msg = req.body.msg;
  conversation.message(
    {
      input: { text: msg },
      workspace_id: workspace_id
    },
    function(err, response) {
      if (err) {
        console.error(err);
      } else {
        var watsonResponse = response.output.text[0];
        res.json(response)
      }
    }
  );
})
```

## [Translate](https://cloud.google.com/translate/) API - GOOGLE - AUTH

```js

app.post('/', (req, res) => {
  var q = req.body.q;
  var options = { method: 'POST',
   url: 'https://translation.googleapis.com/language/translate/v2',
   form:
     { key: process.env.API_KEY,
       q: q,
       target: 'en' } };
  request(options, function (error, response, body) {
    if (error) throw new Error(error);
    res.send(body);
  });
})
```

## Yelp API - [YELP](https://www.yelp.com/fusion) - AUTH

```js
const yelp        = require('yelp-fusion');
const API_KEY      = process.env.YELP_APIKEY;
const client      = yelp.client(API_KEY);
const yelp = require('yelp-fusion');
const API_KEY = process.env.YELP_APIKEY;
const client = yelp.client(API_KEY);
const baseem = require('baseem');

app.get('/:id', (req, res) => {
  const zipcode = req.params.id;

  const searchRequest = {
    term: 'food',
    limit: 10,
    radius: 20000,
    location: zipcode
  };
    client.search(searchRequest)
    .then(response => {
      res.json(response.jsonBody.businesses)
    }).catch(e => {
      console.log(e);
    });
})

```


## [TMDB](https://www.themoviedb.org/documentation/api) - The Movie Database - AUTH

```js
 getFilm() {
  const API_KEY = process.env.TMDB_API_KEY;
  let query = 'batman';
    const url = `https://api.themoviedb.org/3/search/movie?api_key=${API_KEY}&language=en-US&page=1&include_adult=false&query=${query}`;

    axios.get(url)
    .then(data => {
      console.log(data);
    }).catch(err => {
    console.log('error');
    })
  }
```


## [DaBus](http://hea.thebus.org/api_info.asp) API - Honolulu - AUTH
 - The api does not have json :(, you can use this npm package to convert xml to json:

```js
const parseString = require('fast-xml2js').parseString;
```

```js
const busURL = `http://api.thebus.org/arrivals/?key=${API_KEY}&stop=`;
const baseem = require('baseem');

app.get('/:id', (req,res) => {
  var all = []
  var id = req.params.id;
  axios(busURL+id).then((data) => {
    var xml = data.data;
    parseString(xml, function (err, result) {
    var body = result.stopTimes.arrival || [];
    var stop = result.stopTimes.stop;
    var x = body.map((elem,i) => {
      var local = {};
      local.stop = stop[0];
      local.id = elem.id[0];
      local.trip = elem.trip[0];
      local.route = elem.route[0];
      local.headsign = elem.headsign[0];
      local.vehicle = elem.vehicle[0];
      local.direction = elem.direction[0];
      local.stopTime = elem.stopTime[0];
      local.date = elem.date[0];
      local.canceled = parseInt(elem.canceled[0]);
      local.lat = elem.latitude[0];
      local.lng = elem.longitude[0];
      local.shape = elem.shape[0];
      all.push(local);
    })
    res.json(all)
  });
  }).catch(err =>{
    console.log(baseem('error'))
  })
})

```

## [Archive.org](https://archive.org/) API - NO AUTH

```js

app.get('/:id', (req, res) => {
  let rows = req.params.id;
  let mediatype = 'audio';
  let output = 'json';
  let archiveUrl = `https://archive.org/advancedsearch.php?q=subject%3A%22librivox%22+AND+mediatype%3A${mediatype}&fl[]=avg_rating&fl[]=publisher&fl[]=description&fl[]=downloads&fl[]=identifier&fl[]=mediatype&fl[]=num_reviews&fl[]=title&sort[]=&sort[]=&sort[]=&rows=${rows}&page=1&output=${output}`
  axios.get(archiveUrl)
  .then(elem => {
    res.json(elem.data.response.docs);
  })
})
```

## GIFS! - [Giphy](https://developers.giphy.com/docs/) API - AUTH

```js
app.get('/:id', (req, res) => {
  var query = req.params.id;
  var url = `http://api.giphy.com/v1/gifs/search?q=random+${query}&api_key=${apikey}`;
  axios.get(url)
  .then(obj => {
    res.json(obj.data);
  }).catch(err => {
    res.json('error')
  })
})
```

## Song Search - [BPM](https://getsongbpm.com/api) API - AUTH

```js
app.get('/:id', (req, res) => {
  let query = req.params.id;
  let url = `https://api.getsongbpm.com/search/?api_key=${BPM_KEY}&type=song&lookup=${query}`
  axios.get(url)
  .then(data => {
    res.json(data.data.search);
  }).catch(err => {
    res.json('error');
  })
})
```

## Image Emotional Recognition - [AWS](https://aws.amazon.com/rekognition/) Rekognition API - AUTH

- NPM Packages that help:
```js
const multer = require('multer');
const path = require('path');
const baseem = require('baseem');
const fs = require('fs-extra');
const AWS = require('aws-sdk');
const rekognition = new AWS.Rekognition({region: config.region}); //"us-east-1"
```

- Save the photo in a local folder
```js
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'routes/')
  },
  filename: function (req, file, cb) {
    cb(null, 'bat' + path.extname(file.originalname))
  }
});
const upload = multer({ storage: storage });
```

- Create the Params
```js
function getImage(){
  const imagePath = `./bat.jpg`;
  const bitmap = fs.readFileSync(imagePath);
  const params = {
      Image: {
        Bytes: bitmap
      },
      MaxLabels: 10,
      MinConfidence: 50.0
    };
  return params
}
```

```js
app.post('/recognition', upload.single('image'), (req, res) => {
  let params = getImage();
  rekognition.detectLabels(params, function(err, data) {
    if (err) {
      console.log(baseem('error'));
    }else {
      console.log(data);
      res.json(data);
    }
  });
});
```

## Image Label Detection - [AWS](https://aws.amazon.com/rekognition/) Rekognition API - AUTH

- Image submitted for analysis
<img src="./ship.jpg" width="300"/>

- Code for analysis - nodeJs
```js
const AWS = require('aws-sdk');
const baseem = require('baseem');
const rekognition = new AWS.Rekognition({region: "us-east-1"});

var params = {
  Image: {
   S3Object: {
    Bucket: "S3 BUCKET_NAME",
    Name: "ship.jpg"
   }
  },
  MaxLabels: 123,
  MinConfidence: 40
 };
 rekognition.detectLabels(params, function(err, data) {
   if (err) console.log(err, err.stack); // an error occurred
   else     console.log(data);           // successful response
 });
```

- Analysis Response - adjustment on Confidence set lower for testing:
```js
 { Labels:
   [ { Name: 'Boat', Confidence: 99.26506042480469 },
     { Name: 'Transportation', Confidence: 99.26506042480469 },
     { Name: 'Vessel', Confidence: 99.26506042480469 },
     { Name: 'Watercraft', Confidence: 99.26506042480469 },
     { Name: 'Ferry', Confidence: 94.4769287109375 },
     { Name: 'Yacht', Confidence: 69.96138000488281 },
     { Name: 'Dock', Confidence: 53.720726013183594 },
     { Name: 'Pier', Confidence: 53.720726013183594 } ],
  OrientationCorrection: 'ROTATE_0' }
```

## Historical Weather API - DarkSky [Dark](https://darksky.net/forecast/40.7127,-74.0059/us12/en)

```js
const express = require('express');
const app = express();
const baseem = require('baseem');
const DarkSky = require('dark-sky')
const darksky = new DarkSky('process.env.API_KEY');
const beaufort = require('beaufort')
const options = {unit: 'kmh', getName: true};

const degToCompass = (val_num) => {
    let num = parseInt(val_num);
    let val = Math.floor((num / 22.5) + 0.5);
    let arr = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"];
    return arr[(val % 16)];
}

// sample api request -> http://localhost:9000/2017/3/21.308714/-157.808782/8
app.get('/:year/:month/:lat/:lng/:hours', (req, res) => {
  let year = req.params.year;
  let month = req.params.month;
  let lat = req.params.lat;
  let lng = req.params.lng;
  let hours = req.params.hours; // ex. 8 will respond with 0:00am - 08:00am
  month === '2'
  ? count = 28
  : count = 30

  for(let i = 1; i < count; i++){ // run based off days in month
      darksky
      .latitude(lat) // set location lat
      .longitude(lng) // set location lng
      .time(`${year}-${month}-${i}`) // date based off api call
      .units('ca') // kph - mph available - check docs
      .get() // make request
      .then(data=>{
        let num = 0;
        data.hourly.data.map(elem => {
          num ++;
          let timeConverted = new Date(elem.time*1000).toString();
          let y = new Date(timeConverted);
          let z = y.getHours();
          if(parseInt(z) <= hours){
            let local = {
              hour: `Hour: ${num}`,
              time: timeConverted,
              windSpeed: elem.windSpeed,
              beaufort: beaufort(parseInt(elem.windSpeed), options),
              units: 'KPH',
              windBearing: degToCompass(elem.windBearing)
            }
            console.log(local);
          }
        })
      })
      .catch(console.log);
  }
  res.json(baseem('Check your console - Data will be there'));
})

app.listen(9000);
```
 - Output Example:
```js

{ hour: 'Hour: 24',
  time: 983696400,
  windSpeed: 16.8,
  units: 'KPH',
  windBearing: 70 }

```

## Video Analysis with AWS Rekognition - [AWS](https://aws.amazon.com/rekognition/) Rekognition API - AUTH

```js
const express = require('express');
const app = express();
const baseem = require('baseem');
const AWS = require('aws-sdk'); // NPM Package - makes life easier
const rekognition = new AWS.Rekognition({region: "us-east-1"});

// FYI: This will work if you have used AWS-CLI and configured your key/secret key

let params = {
  Video: { /* required */
    S3Object: {
      Bucket: 'bucket_name', // s3 bucket name
      Name: 'video_name.mp4', // video name case sensitive
    }
  },
  ClientRequestToken: 'request_name', // any name you prefer
  MinConfidence: 90,
  NotificationChannel: {
    RoleArn: 'role_arn', // found on AWS IAM Dashboard
    SNSTopicArn: `SNSTopicArn` // found on AWS Service: SNS
  }
};

/* RUN FIRST to get job ID */
rekognition.startLabelDetection(params, function(err, data) {
  if (err) console.log(err, err.stack); // an error occurred
  else     console.log(data);           // successful response
});

let jobID = "from startLabelDetection response";

let params1 = {
  JobId: jobID, /* required */
  MaxResults: 100, // MAX 1000
  NextToken: 'token', // returned if more labels are found
  SortBy: "TIMESTAMP" // NAME
};

rekognition.getLabelDetection(params1, function(err, data) {
  if (err) console.log(err, err.stack); // an error occurred
  else{
    res.json(data.Labels);
  };
});
```

## [Clarifai](https://clarifai.com/) - AUTH

```js
const Clarifai = require('clarifai');
const fs = require('fs-extra');
const ClarifaiApp = new Clarifai.App({ apiKey: process.env._CLARIFAI_KEY });

// additional method of reading image file names from diretory
fs.readdir('./uploads', (err, files) => {
  files.forEach(filename => {
    console.log(filename);
  });
});

// converting image into base64 to send to clarifai api
fs.readFile(`./uploads/${file}`, (err,data) => {
  let base64 = data.toString('base64');
  // clarifai send base64 message
)};

ClarifaiApp.models.predict(Clarifai.GENERAL_MODEL, {base64: base64})
  .then(res => {
    arr.push(res.outputs[0].data.concepts);
    console.log(arr.length);
  })
  .catch(err => {
    console.log("err")
  })
```

## [Twilio](https://www.twilio.com/) - AUTH

```js
const accountSid = process.env.TWILIO_SID;
const authToken = process.env.TWILIO_TOKEN;
const client = require('twilio')(accountSid, authToken);

client.messages
      .create({
         body: `Body message here, is required`,
         from: process.env.TWILIO_CELL,
         to: process.env.TMO_CELL // must be a verified number
       })
      .then(message => console.log(message.sid))
      .done();

```
