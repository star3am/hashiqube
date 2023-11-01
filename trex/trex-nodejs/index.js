const express = require('express')
const path = require('path')
const PORT = process.env.PORT || 6001

express()
  .use(express.static(path.join(__dirname, 'public')))
  .set('views', path.join(__dirname, 'views'))
  .set('view engine', 'ejs')
  .get('/', (req, res) => res.render('pages/index'))
  .get('/now', (req, res) => res.render('pages/now'))
  .listen(PORT, () => console.log(`Listening on ${ PORT }`))
