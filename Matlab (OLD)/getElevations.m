function [elevation] = getElevations(latitude, longitude, keyStr);

% Author: Jarek Tuszynski (jaroslaw.w.tuszynski@leidos.com)
% License: BSD (Berkeley Software Distribution)
% Documentation: https://developers.google.com/maps/documentation/elevation/

%% Check if inputs are available
nPos = numel(latitude); %Number of elements in array
assert(nPos>0, 'Latitude and longitude inputs can not be empty')
assert(nPos==numel(longitude), 'Latitude and longitude inputs are not of the same length')
assert(min(latitude(:)) >= -90 && max(latitude(:)) <= 90, 'Latitudes has to be between -90 and 90')
assert(min(longitude(:))>=-180 && max(longitude(:))<=180, 'Longitude has to be between -180 and 180')

%% Query Google
elevation  = zeros(size(latitude));
batch = [1:50:nPos nPos+1]; % group in batches of 50

for iBatch=2:length(batch)
    idx = batch(iBatch-1):batch(iBatch)-1;
    coord = '';
    for k = 1:length(idx)
        coord = sprintf('%s%9.15f,%9.15f|',coord,latitude(idx(k)),longitude(idx(k)));
    end
    
    %% create query string and run a query
    website = 'https://maps.googleapis.com/maps/api/elevation/xml?locations=';
    url = [website ,coord(1:end-1),'&key=', keyStr];
    str = webread(url);
    
    
    %% Parse results
    status = regexp(str, '<status>([^<]*)<\/status>', 'tokens');
    switch status{1}{1}
        case 'OK'
            res = regexp(str, '<elevation>([^<]*)<\/elevation>', 'tokens');
            elevation(idx) = cellfun(@str2double,res);
        case 'INVALID_REQUEST'
            error('Google Maps API request was malformed');
        case 'OVER_QUERY_LIMIT'
            error('Google Maps API requestor has exceeded quota');
        case 'REQUEST_DENIED'
            error('Google Maps API did not complete the request (invalid sensor parameter?)');
        case 'UNKNOWN_ERROR'
            error('Google Maps API: an unknown error.');
    end
end
end
