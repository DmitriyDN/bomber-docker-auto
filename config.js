module.exports = {
    containersLimit: Number(process.env.MAX_CONTAINERS) || 5,
    chunkSize: Number(process.env.CHUNK_SIZE) || 5,
    timeout: Number(process.env.TIMEOUT) || 1000 * 60 * 5,
    running: 0
};