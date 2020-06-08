%Input
r=[randi(6,10)];
P_KPa=[1:2:55];
IntTension = 0.025;
%end
% Formualation of additional inputs
r=sort(r);
Ar=pi*(r.^2);
So=Ar./sum(Ar);
Soflip=flip(So);
Soil=flip(Socum(Soflip));
Swc=max(Soil);
P_c_KPa=(2*10^3*IntTension)./r;
w=[];
Sw_n=[];
%end

%Coding
for i=1:(length(P_KPa))
       if P_KPa(i)<min(P_c_KPa)
            Sw_n(i)=0;
       elseif P_KPa(i)>=max(P_c_KPa)
               Sw_n(i)=0.8;
        else 
            for j=1:(length(r)-1)
            while P_KPa(i)<P_c_KPa(j);
                j=j+1;
                if Soil(j)>0.8
                    Sw_n(i)=0.8;
                else
                Sw_n(i)=Soil(j);
                end
            end
        end
    end
end
%end

%Output
So=Sw_n;
Sw = 1-Sw_n; 
[P_So_Sw]=[P_KPa',So', Sw']
%end
%Visualisation
plot(Sw,P_KPa,'ob', So,P_KPa,'og',Sw,P_KPa, So,P_KPa)
axis([0,max(1-Sw_n),0,max(P_KPa)])
xlabel('Sw')
ylabel('Pressure')
title('P vs Sw curve')
legend('Sw','So','Sw','So')
legend('boxoff')
%end


%additional function used
function a=Socum(So);
k=length(So);
a=[];
a(1)=So(1);
for i=1:(k-1);
    i=i+1;
    a(i)= So(i)+a(i-1);
end
end
%end

