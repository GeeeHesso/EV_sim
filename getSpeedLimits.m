function [vlim_ref] = getSpeedLimits(trace,keyAPI)


%% create query string and run a query
website = 'https://roads.googleapis.com/v1/speedLimits?path=';
url = [website trace '&key='  keyAPI]
str = webread(url)

end