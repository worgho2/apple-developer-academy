import express from 'express'
import { createTransport } from 'nodemailer'

import sendgrid from '@sendgrid/mail'

const config = {
  port: process.env.PORT || 3000,
  from: 'integratedbudgetsystems@gmail.com',
  sendgridApiKey: process.env.SENDGRID_API_KEY
}

sendgrid.setApiKey(config.sendgridApiKey)

const app = express()
app.use([express.urlencoded({ extended: true }), express.json()])


app.post('/', async (req, res) => {
  try {
    const { to, subject, html } = req.body

    if ([to, subject, html].includes(undefined))
      throw new Error('Validation Error')

    const message = {
      to,
      from: config.from,
      subject,
      html,
    }

    sendgrid.send(message).then((info) => console.log(info)).catch((error) => console.log(error))

    res.send({ message: 'Email scheduled' })
  } catch (error) {
    res.status(500).send({ error: `${error}` })
  }
})

app.listen(config.port, () => {
  console.log(`App started with config: ${JSON.stringify(config, null, 2)}`)
})
