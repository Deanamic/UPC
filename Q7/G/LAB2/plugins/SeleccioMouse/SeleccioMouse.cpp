// GLarena, a plugin based platform to teach OpenGL programming
// © Copyright 2012-2018, ViRVIG Research Group, UPC, https://www.virvig.eu
// 
// This file is part of GLarena
//
// GLarena is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

#include "SeleccioMouse.h"
#include "glwidget.h"
#include <cmath>

void encodeID(int index, GLubyte *color) {
  color[0]=color[1]=color[2]= index+1;
  cerr << index << ' ' << int(color[0]) << endl;
}

int decodeID(GLubyte *color) {
  if (color[0]==255) return -1;
  return color[0]-1;
}

void Selecciomouse::onPluginLoad()
{

    // Carregar shader, compile & link 
    QString vs_src = 
    	"#version 330 core\n"
    	"layout (location = 0) in vec3 vertex;"

	"uniform mat4 modelViewProjectionMatrix;"

	"void main(void)"
	"{"
    		"gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);"
	"}";
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceCode(vs_src);
    cout << "VS log:" << vs->log().toStdString() << endl;

    QString fs_src = "#version 330 core\n"
        "uniform vec4 color1;"
	"out vec4 fragColor;"

	"void main(void)"
	"{"
    		"fragColor = vec4(1,1,1,0);"
	"}";
    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceCode(fs_src);
    cout << "FS log:" << fs->log().toStdString() << endl;

    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    cout << "Link log:" << program->log().toStdString() << endl;

}

void Selecciomouse::mousePressEvent(QMouseEvent *e){
   if (!(e->button()&Qt::LeftButton)) return;          // boto esquerre del ratoli
   if (e->modifiers()&(Qt::ShiftModifier)) return;     // res de tenir shift pulsat
   if (!(e->modifiers()&Qt::ControlModifier)) return; // la tecla control ha d'estar pulsada
  
   glClearColor(0, 0, 0, 0);                           // esborrar els buffers amb un color de fons únic (blanc)
   glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

  program->bind();
  const vector<Object> &objs = scene()->objects();
  cout <<objs.size() << endl;
  for (uint i = 0; i < objs.size(); ++i) {
    GLubyte color[4];
    encodeID(i,color);
    program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix()*camera()->viewMatrix());
    program->setUniformValue("color1", QVector4D(color[0]/255.0, color[1]/255., color[2]/255., 1.0));
    //program->setUniformValue("color1", QVector4D(1, 1, 0, 1.0));
    drawPlugin()->drawObject(i);
  }
  program->release();

  int x = e->x();
  int y = glwidget()->height() - e->y();
  GLubyte read[4];
  glReadPixels(x, y, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, read);
  int ID = decodeID(&read[0]);

  cout << float(read[0]) << endl;
  
  cout << "ID1: " << ID << endl;
  
  scene()->setSelectedObject(ID);
  glwidget()->update();
}



void Selecciomouse::cleanUp()
{

  GLWidget & g = *glwidget();
  g.glDeleteBuffers(m_size, &m_coordBufferID);
  g.glDeleteVertexArrays(1, &m_VAO);
  
  delete program;
  delete fs;
  delete vs;

}
void Selecciomouse::postFrame(){

	//cout << scene()->selectedObject() << endl;
}




