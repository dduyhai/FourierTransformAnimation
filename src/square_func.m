function [val, a, b] = square_func(x, p, fourier_order)
    arguments
        x = []
        p = []
        fourier_order {mustBeInteger, mustBeScalarOrEmpty} = [];
    end
    if ~isempty(fourier_order) && (fourier_order >= 0)
        a = zeros([fourier_order + 1, 1]);
        b = zeros([fourier_order + 1, 1]);
        a(1) = 0.5;
        if (fourier_order >= 1)
            n = (1:fourier_order)';
            a(2:end) = (1/pi) ./ n .* sin(pi * n);
            b(2:end) = (2/pi) ./ n .* (sin(pi/2 * n).^2);
        end
    end
    if isempty(x)
        val = [];
        return;
    end
    x = x  - floor(x / p) * p;
    val = zeros(size(x));
    ids = find(x < 0.5 * p);
    val(ids) = 1.0;
end
