function controller = fuzzy_PI_controller()

% Initialize FZ - PI
controller = newfis('fis', 'AggregationMethod', 'sum');

% Adding inputs
controller = addvar(controller,'input', 'dh', [0 1]);
controller = addvar(controller,'input', 'dv', [0 1]);
controller = addvar(controller,'input', 'theta', [-180 180]);

% Adding outputs
controller = addvar(controller,'output', 'dtheta', [-130 130]);

% Adding rules - dh
controller = addmf(controller,'input',1,'S','trimf', [-0.5 0 0.5]);
controller = addmf(controller,'input',1,'M','trimf', [0 0.5 1]);
controller = addmf(controller,'input',1,'L','trimf', [0.5 1 1.5]);

% Adding rules - dv
controller = addmf(controller,'input',2,'S','trimf', [-0.5 0 0.5]);
controller = addmf(controller,'input',2,'M','trimf', [0 0.5 1]);
controller = addmf(controller,'input',2,'L','trimf', [0.5 1 1.5]);

% Adding rules - theta
controller = addmf(controller,'input',3,'N','trimf', [-360 -180 0]);
controller = addmf(controller,'input',3,'ZR','trimf', [-180 0 180]);
controller = addmf(controller,'input',3,'P','trimf', [0 180 360]);

% Adding rules - dtheta
controller = addmf(controller,'output',1,'N','trimf', [-260 -130 0]);
controller = addmf(controller,'output',1,'ZR','trimf', [-130 0 130]);
controller = addmf(controller,'output',1,'P','trimf', [0 130 260]);

end