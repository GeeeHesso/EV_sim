%function [latitude, longitude, latz, lonz, iti_dist, iti_time] = getItinerary(start,destination,keyAPI)
function [latitude, longitude] = getDirections(start,destination,keyAPI)

%% Création de l'URL
website = 'https://maps.googleapis.com/maps/api/directions/xml?origin=';
url = [website start '&destination=' destination '&key='  keyAPI];
str = webread(url);


%% Parse results
%initialisation des variables
iti_lat=[];
latz=[];
iti_lon=[];
lonz=[];
res1 = 0;
res2 =0;
res3 =0;
res4 =0;
reg=0;

%Traitement du statut de la réponse
status = regexp(str, '<status>([^<]*)<\/status>', 'tokens');
switch status{1}{1}
    case 'OK'
        %Déchiffrement de la réponse de l'API
        res4 = regexp(str, '<points>([^<]*)<\/points>', 'tokens');
        
        %Traitement simplifié <overview_polyline>
        e = res4(length(res4));
        e = string({e});
        e = char(e);
        [latitude,longitude] = decodeGooglePolyLine(e,0);
%         
%         %Traitement complet de chaque <step>
%         lati=[];
%         longi=[];
%         for k=1:1:length(res4)-1
%             e = res4(k);
%             e = string({e});
%             e = char(e);
%             [lat,lon] = decodeGooglePolyLine(e,0);
%             
%             start=length(lati);
%             for i=1:1:length(lat)
%                 lati(i+start)=lat(i);
%                 longi(i+start)=lon(i);
%             end
%         end
%         latitude = lati;
%         longitude = longi;
        
    case 'NOT_FOUND'
        error('Google Maps API: NOT FOUND.');
    case 'ZERO_RESULTS'
        error('Google Maps API: ZERO RESULTS.');
    case 'MAX_WAYPOINTS_EXCEEDED'
        error('Google Maps API: WAYPOINTS EXCEEDED.');
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

