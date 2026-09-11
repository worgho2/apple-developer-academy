# email-service

Node.js microservice for the Integrated Budget system. It exposes one endpoint that sends an HTML email through SendGrid on behalf of the iOS app.

`index.js` starts an Express server and accepts `POST /` with a JSON body of `to`, `subject` and `html`. The message is sent from the configured address with the SendGrid API key taken from the environment. Nodemailer is installed as an alternative transport but the SendGrid path is the one in use.

## Run

```bash
npm install
cp .env.example .env    # fill in SENDGRID_API_KEY
npm run dev             # env-cmd + nodemon, reads .env
```

For production, `npm start` runs `node index.js` with the variables already in the environment. The port comes from `PORT` and defaults to 3000.
