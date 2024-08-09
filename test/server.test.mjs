import request from 'supertest';
import app from '../server.js';
import { expect } from 'chai';

describe('GET /', () => {
  it('should respond with "Hello, World!"', (done) => {
    request(app)
      .get('/')
      .end((err, res) => {
        if (err) return done(err);
        expect(res.text).to.equal('Hello, World!');
        expect(res.status).to.equal(200);
        done();
      });
  });
});
