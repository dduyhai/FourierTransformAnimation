function animate_periodic_function(fun, opt)
    arguments
        fun
        opt.Period  (1,1) double {mustBePositive, mustBeNonempty} = 2*pi
        opt.Parent = []
        opt.TimeStep (1,1) double {mustBePositive, mustBeNonempty} = 0.01;
        opt.NumberOfPeriods (1,1) double {mustBeInteger, mustBePositive} = 3
        opt.FourierOrder (1, :) double {mustBeNonnegative}  = 10;
    end
    colors = ["#0072BD", "#D95319", "#EDB120", "#7E2F8E", ...
        "#77AC30", "#4DBEEE", "#A2142F"];
    markers = ["o", "x", "square", "^", "pentagram"];

    dt = opt.TimeStep;
    time_points = (0.0 : dt : opt.NumberOfPeriods * opt.Period);
    
    a = cell([numel(opt.FourierOrder), 1]);
    b = cell([numel(opt.FourierOrder), 1]);
    apprx_s = cell([numel(opt.FourierOrder), 1]);
    for i = 1:numel(opt.FourierOrder)
        [~, a{i}, b{i}] = fun([], [], opt.FourierOrder(i));
        apprx_s{i} = fourier_series(a{i}, b{i}, opt.Period, time_points);
    end
    s = fun(time_points, opt.Period);
    current_time = opt.Period;
    if isempty(opt.Parent)
        fig = figure(Name = "Banana");
    else
        fig = figure(Parent = opt.Parent, Name = "Banana");
    end
    ax = axes(fig);

    while (true)
        if isempty(findobj("Name", "Banana"))
            break;
        end 
        current_time = current_time + dt;
        s(1 : (end - 1)) = s(2:end);
        s(end) = fun(current_time, opt.Period);
        for i = 1 : numel(opt.FourierOrder)
            tmp = apprx_s{i};
            tmp(1 : (end - 1)) = tmp(2 : end);
            tmp(end) = fourier_series(a{i}, b{i}, opt.Period, current_time);
            apprx_s{i} = tmp;
        end
        plot(ax, time_points, s, Color = "k", LineWidth = 1.3);
        hold(ax, "on");
        for i = 1 : numel(opt.FourierOrder)
            color_id = mod(numel(colors), i) + 1;
            marker_id = mod(numel(markers), i) + 1;
            plot(ax, time_points, apprx_s{i}, Color = colors(color_id), ...
                Marker = markers(marker_id));
        end
        hold(ax, "off");
        drawnow();
    end
end

function val = fourier_series(a, b, P, t)
    a = a(:);
    b = b(:);
    t = t(:).';
    n = (1 : (numel(a) - 1))';
    if isempty(n)
        val = repmat(a(1), 1, numel(t));
        return;
    end
    val = a(1) + a(2:end).' * cos((2 * pi / P * t) .* n) + b(2:end).' * sin((2 * pi / P * t) .* n);
end
