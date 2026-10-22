const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
app.get('/health', (_req, res) => res.json({ ok: true, service: 'poker-social-server-demo' }));
const server = http.createServer(app);
const io = new Server(server, { cors: { origin: '*' } }); // Development only.

const rooms = new Map();
io.on('connection', socket => {
  socket.emit('server:hello', { message: 'Connected to demo server' });
  socket.on('room:join', ({ roomId, displayName } = {}) => {
    if (typeof roomId !== 'string' || !roomId.trim() || roomId.length > 32) {
      socket.emit('error:notice', { message: 'Invalid room ID' }); return;
    }
    const name = typeof displayName === 'string' ? displayName.replace(/[<>]/g, '').slice(0, 20) : 'Player';
    if (!rooms.has(roomId)) rooms.set(roomId, []);
    const players = rooms.get(roomId);
    if (players.length >= 8) { socket.emit('error:notice', { message: 'Table is full (max 8 players)' }); return; }
    if (!players.some(p => p.id === socket.id)) players.push({ id: socket.id, name });
    socket.join(roomId);
    io.to(roomId).emit('room:update', { roomId, players: players.map(p => ({ name: p.name })), count: players.length });
  });
  socket.on('disconnect', () => {
    for (const [roomId, players] of rooms) {
      const next = players.filter(p => p.id !== socket.id);
      if (next.length !== players.length) {
        if (next.length) rooms.set(roomId, next); else rooms.delete(roomId);
        io.to(roomId).emit('room:update', { roomId, players: next.map(p => ({ name: p.name })), count: next.length });
      }
    }
  });
});
server.listen(Number(process.env.PORT || 3000), () => console.log('Demo server listening on port 3000'));
