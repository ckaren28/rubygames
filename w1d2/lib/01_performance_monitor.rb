def measure(pass = 1)
  start = Time.now
  pass.times {yield}
  (Time.now - start) / pass

end
