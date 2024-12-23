function [val, a, b] = half_sin_func(x, p, fourier_order)
    arguments
        x = []
        p = []
        fourier_order {mustBeInteger, mustBeScalarOrEmpty} = [];
    end
    if ~isempty(fourier_order) && (fourier_order >= 0)
        a = zeros([fourier_order + 1, 1]);
        b = zeros([fourier_order + 1, 1]);
        a(1) = 1 / pi;
        if (fourier_order >= 1)
            b(2) = 0.5;
            a(3 : 2 : end) = (-2.0 / pi) ./ ((2 : 2 : fourier_order).^2 - 1);
        end
    end
    if isempty(x)
        val = [];
        return;
    end
    x = x - floor(x / p) * p;
    val = zeros(size(x));
    ids = find(x < 0.5 * p);
    val(ids) = sin((2 * pi / p) * x(ids)); 
end
