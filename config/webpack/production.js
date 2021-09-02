process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./env')

module.exports = environment.toWebpackConfig()
