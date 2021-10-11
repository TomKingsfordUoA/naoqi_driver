FROM ros:melodic-ros-core

RUN apt update
RUN apt install -y build-essential

RUN apt install -y python-rosdep
run rosdep init && rosdep update

COPY . /catkin_ws/src/naoqi_driver
WORKDIR /catkin_ws
RUN bash -c "source /opt/ros/melodic/setup.sh; rosdep install -i -y --from-paths /catkin_ws/src/naoqi_driver"
RUN bash -c "source /opt/ros/melodic/setup.sh; catkin_make"

COPY docker-entrypoint.sh /
ENTRYPOINT /docker-entrypoint.sh
