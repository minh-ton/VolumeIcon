FasdUAS 1.101.10   ��   ��    k             l     ��  ��    2 , This is the main script for VolumeIcon app.     � 	 	 X   T h i s   i s   t h e   m a i n   s c r i p t   f o r   V o l u m e I c o n   a p p .   
  
 l     ��������  ��  ��        l     ��  ��    7 1 Copyright � 2020 fordApps. All rights reserved.      �   b   C o p y r i g h t   �   2 0 2 0   f o r d A p p s .   A l l   r i g h t s   r e s e r v e d .        l     ��������  ��  ��        l     ��  ��    > 8 Created by MinhTon. Github: https://github.com/Minh-Ton     �   p   C r e a t e d   b y   M i n h T o n .   G i t h u b :   h t t p s : / / g i t h u b . c o m / M i n h - T o n      l     ��  ��           �           l     ��   ��    � � This script is totally open-source. You can copy this script to another directory and edit it. Do not edit this script while it is still in the app package to prevent codesigning error.       � ! !v   T h i s   s c r i p t   i s   t o t a l l y   o p e n - s o u r c e .   Y o u   c a n   c o p y   t h i s   s c r i p t   t o   a n o t h e r   d i r e c t o r y   a n d   e d i t   i t .   D o   n o t   e d i t   t h i s   s c r i p t   w h i l e   i t   i s   s t i l l   i n   t h e   a p p   p a c k a g e   t o   p r e v e n t   c o d e s i g n i n g   e r r o r .     " # " l     ��������  ��  ��   #  $ % $ l     �� & '��   &  > First step    ' � ( (  >   F i r s t   s t e p %  ) * ) l    	 +���� + r     	 , - , n      . / . 1    ��
�� 
psxp / l     0���� 0 I    �� 1��
�� .earsffdralis        afdr 1  f     ��  ��  ��   - o      ���� 0 app_directory  ��  ��   *  2 3 2 l  
  4���� 4 r   
  5 6 5 n   
  7 8 7 1    ��
�� 
strq 8 l  
  9���� 9 b   
  : ; : o   
 ���� 0 app_directory   ; m     < < � = = J C o n t e n t s / R e s o u r c e s / V o l u m e I c o n . c o m m a n d��  ��   6 o      ���� 0 
volumeicon 
VolumeIcon��  ��   3  > ? > l    @���� @ r     A B A n     C D C 1    ��
�� 
strq D l    E���� E b     F G F o    ���� 0 app_directory   G m     H H � I I D C o n t e n t s / R e s o u r c e s / s t e p 1 _ d e l e t e . s h��  ��   B o      ���� 0 step1_clrtmp  ��  ��   ?  J K J l   ! L���� L r    ! M N M n     O P O 1    ��
�� 
strq P l    Q���� Q b     R S R o    ���� 0 app_directory   S m     T T � U U D C o n t e n t s / R e s o u r c e s / s t e p 2 _ d e l e t e . s h��  ��   N o      ���� 0 step2_clrtmp  ��  ��   K  V W V l  " ) X���� X r   " ) Y Z Y n   " ' [ \ [ 1   % '��
�� 
strq \ l  " % ]���� ] b   " % ^ _ ^ o   " #���� 0 app_directory   _ m   # $ ` ` � a a D C o n t e n t s / R e s o u r c e s / r e b o o t _ s c r p t . s h��  ��   Z o      ���� 0 reboot_scrpt  ��  ��   W  b c b l     �� d e��   d ! > Hide/minimize all windows    e � f f 6 >   H i d e / m i n i m i z e   a l l   w i n d o w s c  g h g l  * K i���� i O   * K j k j k   . J l l  m n m r   . > o p o m   . /��
�� boovfals p 6  / = q r q n   / 4 s t s 1   2 4��
�� 
pvis t 2   / 2��
�� 
prcs r =  5 < u v u 1   6 8��
�� 
pvis v m   9 ;��
�� boovtrue n  w�� w r   ? J x y x m   ? @��
�� boovtrue y l      z���� z n       { | { 1   E I��
�� 
wshd | 2  @ E��
�� 
cwin��  ��  ��   k m   * + } }�                                                                                  MACS  alis    :  	Macintosh                      BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p   	 M a c i n t o s h  &System/Library/CoreServices/Finder.app  / ��  ��  ��   h  ~  ~ l     �� � ���   �  > Execute the script    � � � � ( >   E x e c u t e   t h e   s c r i p t   � � � l  L ] ����� � I  L ]�� � �
�� .sysoexecTEXT���     TEXT � b   L U � � � b   L Q � � � m   L O � � � � � z / A p p l i c a t i o n s / U t i l i t i e s / T e r m i n a l . a p p / C o n t e n t s / M a c O S / T e r m i n a l   � o   O P���� 0 
volumeicon 
VolumeIcon � m   Q T � � � � �    > / d e v / n u l l   & � �� ���
�� 
badm � m   X Y��
�� boovtrue��  ��  ��   �  � � � l     �� � ���   �  > Cleaning up files    � � � � & >   C l e a n i n g   u p   f i l e s �  � � � l  ^ g ����� � I  ^ g�� � �
�� .sysoexecTEXT���     TEXT � o   ^ _���� 0 step1_clrtmp   � �� ���
�� 
badm � m   b c��
�� boovtrue��  ��  ��   �  � � � l  h q ����� � I  h q�� � �
�� .sysoexecTEXT���     TEXT � o   h i���� 0 step2_clrtmp   � �� ���
�� 
badm � m   l m��
�� boovtrue��  ��  ��   �  � � � l  r w ����� � r   r w � � � m   r s����  � o      ���� 0 n  ��  ��   �  � � � l  x � ����� � r   x � � � � o   x {���� 0 n   � 1   { ���
�� 
ppgt��  ��   �  � � � l  � � ����� � r   � � � � � m   � � � � � � �  V o l u m e I c o n   v 2 . 2 � 1   � ���
�� 
ppgd��  ��   �  � � � l  � � ����� � r   � � � � � m   � � � � � � � < C l e a n i n g   u p   t e m p o r a r y   f i l e s . . . � 1   � ���
�� 
ppga��  ��   �  � � � l  � � ����� � Y   � � ��� � ��� � k   � � � �  � � � I  � ��� ���
�� .sysodelanull��� ��� nmbr � m   � ����� ��   �  ��� � r   � � � � � o   � ����� 0 i   � 1   � ���
�� 
ppgc��  �� 0 i   � m   � �����  � o   � ����� 0 n  ��  ��  ��   �  � � � l     �� � ���   �  > Promp user to restart    � � � � . >   P r o m p   u s e r   t o   r e s t a r t �  � � � l  � � ����� � I  � ��� � �
�� .sysodisAaleR        TEXT � m   � � � � � � � : M e s s a g e s   f r o m   V o l u m e I c o n   v 2 . 2 � �� � �
�� 
mesS � m   � � � � � � � z W o u l d   y o u   l i k e   t o   r e s t a r t   y o u r   M a c   f o r   c h a n g e s   t o   b e   a p p l i e d ? � �� � �
�� 
as A � m   � ���
�� EAlTcriT � �� � �
�� 
btns � J   � � � �  � � � m   � � � � � � �  R e s t a r t   l a t e r �  ��� � m   � � � � � � �  R e s t a r t   n o w��   � �� � �
�� 
dflt � m   � � � � � � �  R e s t a r t   n o w � �� ���
�� 
cbtn � m   � � � � � � �  R e s t a r t   l a t e r��  ��  ��   �  ��� � l  � ���~ � Z   � � ��} � � =  � � � � � l  � � ��|�{ � n   � � � � � 1   � ��z
�z 
bhit � l  � � ��y�x � 1   � ��w
�w 
rslt�y  �x  �|  �{   � m   � � � � � � �  R e s t a r t   n o w � k   � � � �  � � � I  � ��v ��u
�v .sysoexecTEXT���     TEXT � o   � ��t�t 0 reboot_scrpt  �u   �  ��s � I  � ��r�q�p
�r .aevtquitnull��� ��� null�q  �p  �s  �}   � I  ��o�n�m
�o .aevtquitnull��� ��� null�n  �m  �  �~  ��       �l � ��l   � �k
�k .aevtoappnull  �   � **** � �j ��i�h � �g
�j .aevtoappnull  �   � **** � k      )  2  >  J  V  g  �  �		  �

  �  �  �  �  �  �  ��f�f  �i  �h   � �e�e 0 i    0�d�c�b <�a�` H�_ T�^ `�] }�\�[�Z�Y � ��X�W�V�U ��T ��S�R�Q ��P ��O�N�M � ��L ��K ��J�I�H�G ��F
�d .earsffdralis        afdr
�c 
psxp�b 0 app_directory  
�a 
strq�` 0 
volumeicon 
VolumeIcon�_ 0 step1_clrtmp  �^ 0 step2_clrtmp  �] 0 reboot_scrpt  
�\ 
prcs
�[ 
pvis  
�Z 
cwin
�Y 
wshd
�X 
badm
�W .sysoexecTEXT���     TEXT�V 0 n  
�U 
ppgt
�T 
ppgd
�S 
ppga
�R .sysodelanull��� ��� nmbr
�Q 
ppgc
�P 
mesS
�O 
as A
�N EAlTcriT
�M 
btns
�L 
dflt
�K 
cbtn�J 

�I .sysodisAaleR        TEXT
�H 
rslt
�G 
bhit
�F .aevtquitnull��� ��� null�g)j  �,E�O��%�,E�O��%�,E�O��%�,E�O��%�,E�O� f*�-�,�[�,\Ze81FOe*a -a ,FUOa �%a %a el O�a el O�a el OlE` O_ *a ,FOa *a ,FOa *a ,FO k_ kh  kj O�*a ,F[OY��Oa a a  a !a "a #a $a %lva &a 'a (a )a * +O_ ,a -,a .  �j O*j /Y *j /ascr  ��ޭ