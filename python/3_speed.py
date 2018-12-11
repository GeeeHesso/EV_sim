import matplotlib.pyplot as plt
import numpy as np
import math

def create_profile_real(point,acc_in,acc_out,max_speed,length,plot):
	# More accurate accord to the equations of movements

	#Initialization
	slope_1=np.zeros(length)
	slope_1_inv=np.zeros(length)
	slope_2=np.zeros(length)
	slope_3=max_speed*np.ones(length)	

	#According to the equation of motion
	# v(x) = (2ax+v_0**2)**(1/2)
	for i in range(0,point[0]+1):
		slope_1_inv[i] = math.sqrt(2*i*(-acc_in)+point[1]**2) #TODO careful with the negative

	slope_1[0:point[0]+1]=np.flip(slope_1_inv[0:point[0]+1],0)

	for i in range(point[0],length):
		slope_2[i] = math.sqrt(2*(i-point[0])*acc_out+point[1]**2)

	profile_slope = np.maximum(slope_1,slope_2)
	profile = np.minimum(profile_slope,slope_3)

	if plot:
		plt.plot(slope_1_inv,label="slope_1_inv")
		plt.legend()
		plt.figure()
		plt.plot(slope_1,label="slope_1")
		plt.legend()
		plt.figure()
		plt.plot(slope_2,label="slope_2")
		plt.legend()
		plt.figure()
		plt.plot(profile_slope,label="profile_slope")
		plt.legend()
		plt.figure()
		plt.plot(profile,label="profile")
		plt.legend()
		plt.figure()


	return profile

speed_1=33*np.ones(100)

speed_1[50] = 25

speed_o=np.array(speed_1)

acc_in      = -20 #Negative acceleration vehicle loosing speed while braking
acc_out     =  10  #positive acceleration vehicle picking up speed after a braking event
speed_limit =  33

for i in range(100):
	if i == 50:
		plot=True
	else:
		plot=False

	profile = create_profile_real([i,speed_1[i]],acc_in,acc_out,speed_limit,100,plot)
	speed_1=np.minimum(speed_1,profile)

plt.plot(speed_o)
plt.plot(speed_1)
plt.show()