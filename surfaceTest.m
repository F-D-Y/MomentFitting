function tests = surfaceTest
    tests = functiontests(localfunctions);
end

function testStraightVertical(~)
    phi = @(x,y)x;
    gradPhi = {@(x,y)1 @(x,y)0};
    exactLength = 2;

    [~, w] = getSurfaceRule(phi, gradPhi, 2);

    error = abs(sum(w) - exactLength);
    assert(error < 1e-14);
end

function testStraightHorizontal(~)
    phi = @(x,y)y;
    gradPhi = {@(x,y)0 @(x,y)1};
    exactLength = 2;

    [~, w] = getSurfaceRule(phi, gradPhi, 2);

    error = abs(sum(w) - exactLength);
    assert(error < 1e-14);
end

function testStraightVerticalShifted(~)
    phi = @(x,y)x - 0.5;
    gradPhi = {@(x,y)1 @(x,y)0};
    exactLength = 2;

    [~, w] = getSurfaceRule(phi, gradPhi, 2);

    error = abs(sum(w) - exactLength);
    assert(error < 1e-14);
end

function testStraightDiagonal(~)
    phi = @(x,y)x+y;
    gradPhi = {@(x,y)1 @(x,y)1};
    exactLength = 2 * sqrt(2);

    [~, w] = getSurfaceRule(phi, gradPhi, 2);
    
    error = abs(sum(w) - exactLength);
    assert(error < 1e-14);
end

function testCircleSection(~)
    phi = @(x,y)(x-1.5)^2 + (y-1.5)^2 - 5/2;
    gradPhi = {@(x,y)2*(x-1.5) @(x,y)2*(y-1.5)};
    exactLength = 1.46618247613376;
    
    errors = zeros(1, 5);
    for i=1:5
        [~, w] = getSurfaceRule(phi, gradPhi, i);
        errors(i) = abs(sum(w) - exactLength);
    end
    
    thresholds = [ 0.3 0.07 0.04 0.004 0.002 ];
    assert(all(errors < thresholds));
end