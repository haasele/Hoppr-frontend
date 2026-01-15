// Minimal drift worker - placeholder
// The actual worker should be generated or downloaded from drift releases
self.onmessage = function(e) {
  if (e.data && e.data.type === 'init') {
    self.postMessage({type: 'ready'});
  }
};
