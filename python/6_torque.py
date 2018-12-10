import numpy as np
import random
import matplotlib.pyplot as plt


def get_torque(speed,acc):
	
	'''
mu	---------------mu1
					 \
					  \
					   \
	...................m0......................................
	\				   /
	 \				  /
	  \				 /
md	   \md1------md2/

	'''
	mu=10		#[N/m]
	md=-10		#[N/m]
	mu1=100		#[m/s]
	md1=10		#[m/s]
	md2=100		#[m/s]
	m0=150		#[m/s]

	r_torque = 0
	if acc > 0: # speeding UP
		r_torque = np.interp(speed,[0,mu1,m0],[mu,mu,0])

	if acc < 0: #speeding DOWN
		r_torque = np.interp(speed,[0,md1,md2,m0],[0,md,md,0])	


	return r_torque



if __name__ == '__main__':
	
	random.seed()
	a_speed=[]
	a_torque=[]

	for i in range(100000):
		s=random.uniform(0,200)
		a=random.randint(0,1)
		if a == 0:
			a=-1

		t=get_torque(s,a)

		a_speed.append(s)
		a_torque.append(t)

	plt.plot(a_speed,a_torque,'x')
	plt.show()