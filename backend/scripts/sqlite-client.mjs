/** SQLite connection facade for the existing date-range demo seed tools. */
import { database } from '../dist/database.js'
export default {
  async createConnection() {
    const connection = await database.getConnection()
    return {
      query: connection.query.bind(connection), execute: connection.execute.bind(connection),
      beginTransaction: connection.beginTransaction.bind(connection),
      commit: connection.commit.bind(connection), rollback: connection.rollback.bind(connection),
      async end() { connection.release(); await database.end() },
    }
  },
}
