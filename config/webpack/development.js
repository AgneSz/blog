process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./env')

module.exports = environment.toWebpackConfig()
