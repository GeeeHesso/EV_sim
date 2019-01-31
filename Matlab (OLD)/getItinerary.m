function [latitude, longitude, latz, lonz, iti_dist, iti_time] = getItinerary(start,destination,keyAPI)

%% create query string and run a query
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
status = regexp(str, '<status>([^<]*)<\/status>', 'tokens');
switch status{1}{1}
    case 'OK'
        %Déchiffrement de la réponse de l'API
        res1 = regexp(str, '<lat>([^<]*)<\/lat>', 'tokens');
        iti_lat = cellfun(@str2double,res1);
        res2 = regexp(str, '<lng>([^<]*)<\/lng>', 'tokens');
        iti_lon = cellfun(@str2double,res2);
        res3 = regexp(str, '<value>([^<]*)<\/value>', 'tokens');
        reg = cellfun(@str2double,res3);
        res4 = regexp(str, '<points>([^<]*)<\/points>', 'tokens');
        
        %Récupération du temps et de la distance
        a=1;
        b=1;
        for k=1:1:length(reg)-1
            if mod(k,2)~= 0
                time(a)=reg(k);
                a = a+1;
            end
            if mod(k,2)==0
                dist(b)=reg(k);
                b = b+1;
            end
        end
        
        iti_dist(1)=0;
        iti_time(1)=0;
        for k=2:1:length(dist)+1
            iti_dist(k)=iti_dist(k-1)+dist(k-1);
            iti_time(k)=iti_time(k-1)+time(k-1);
        end
        
        %Définition lonz et latz
        q=1;
        for k=1:1:length(iti_lat)-4
            if k<=2
                u=1;
            end
            if k>=3
                u=2;
            end
            switch u
                case 1
                    latz(q) = iti_lat(k);
                    lonz(q) = iti_lon(k);
                    q=q+1;
                case 2
                    if mod(k,2)==0
                        latz(q) =iti_lat(k);
                        lonz(q) = iti_lon(k);
                        q=q+1;
                    end
            end
        end
        
                e = res4(length(res4));
                e = string({e});
                e = char(e);
                [latitude,longitude] = decodeGooglePolyLine(e,0);

%Test pour augmenter la précision mais encore pire
%                 res='';
%                 lati=[];
%                 longi=[];
%                 for k=1:1:length(res4)-1
%                     e = res4(k);
%                     e = string({e});
%                     e = char(e);
%                     [lat,lon] = googlePolyLineDecoder(e,0);
%                     
%                     start=length(lati);
%                     for i=1:1:length(lat)
%                         lati(i+start)=lat(i);
%                         longi(i+start)=lon(i);
%                     end
%                 end
%                 latitude = lati;
%                 longitude = longi;

        % % %
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

