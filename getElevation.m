function [elevation] = getElevation(latitude, longitude, keyAPI)


%% Contrôle de la validité des latitudes et longitudes
nPos = numel(latitude); %Number of elements in array
assert(nPos>0, 'Latitude and longitude inputs can not be empty')
assert(nPos==numel(longitude), 'Latitude and longitude inputs are not of the same length')
assert(min(latitude(:)) >= -90 && max(latitude(:)) <= 90, 'Latitudes has to be between -90 and 90')
assert(min(longitude(:))>=-180 && max(longitude(:))<=180, 'Longitude has to be between -180 and 180')

% %% Requete Google
elevation  = zeros(size(latitude)); %Création matrice NxN vide
groupe = [1:100:nPos nPos+1]; % Grouper par lot de 100

for k=2:length(groupe)
    idx = groupe(k-1):groupe(k)-1; %Position
    coord = '';
    for i = 1:length(idx)
        coord = sprintf('%s%9.15f,%9.15f|',coord,latitude(idx(i)),longitude(idx(i))); %Création de Path
    end

    %% Création de l'URL
    website = 'https://maps.googleapis.com/maps/api/elevation/xml?locations=';
    url = [website ,coord(1:end-1),'&key=', keyAPI];
    str = webread(url);


    %% Traitement de la réponse API
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
