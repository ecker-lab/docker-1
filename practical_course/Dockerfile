FROM eckerlabdocker/docker:cuda11.0-py3.8-torch1.7-tf2.4

RUN conda install "notebook>=5.3" "ipywidgets>=7.5"
RUN conda install plotly 
RUN pip install trimesh
RUN jupyter labextension install jupyterlab-plotly@4.14.3

