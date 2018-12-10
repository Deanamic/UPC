#include "Illuminacio.h"
#include "glwidget.h"

void Illuminacio::onPluginLoad()
{
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile("./Lighting2.vert");
    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile("./Lighting2.frag");
    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
}

void Illuminacio::preFrame()
{
	if (program && program->isLinked()) {
    program->bind();
    const Camera* cam=camera();
    program->setUniformValue("modelViewProjectionMatrix", cam->projectionMatrix()*cam->viewMatrix());
    program->setUniformValue("modelViewMatrix", cam->viewMatrix());
    program->setUniformValue("normalMatrix", cam->viewMatrix().normalMatrix());
    //lightAmbient = Vector(0.1,0.1,0.1);
    //lightDiffuse = Vector(1,1,1);
    //lightSpecular = Vector(1,1,1);
    //lightPosition = QVector4D(0,0,0,1);
    program->setUniformValue("lightAmbient", QVector4D(Vector(0.1,0.1,0.1),1));
    program->setUniformValue("lightDiffuse", QVector4D(Vector(1,1,1),1));
    program->setUniformValue("lightSpecular", QVector4D(Vector(1,1,1),1));
    program->setUniformValue("lightPosition", QVector4D(0,0,0,1));
    //materialAmbient = Vector(0.8, 0.8, 0.6);
    //materialDiffuse = Vector(0.8, 0.8, 0.6);
    //materialSpecular = Vector(1.0, 1.0, 1.0);
    //materialShininess = 64.0;
    program->setUniformValue("matAmbient", QVector4D(Vector(0.5, 0.5, 0.0),1));
    program->setUniformValue("matDiffuse", QVector4D(Vector(0.2, 0.8, 0.6),1));
    program->setUniformValue("matSpecular", QVector4D(Vector(1.0, 1.0, 1.0),1));
    program->setUniformValue("matShininess", GLfloat(64.0));
  }
}
void Illuminacio::postFrame()
{
	 if (program && program->isLinked()) program->release();
}

void Illuminacio::onObjectAdd()
{
	
}

bool Illuminacio::drawScene()
{
	return false; // return true only if implemented
}

bool Illuminacio::drawObject(int)
{
	return false; // return true only if implemented
}

bool Illuminacio::paintGL()
{
	return false; // return true only if implemented
}

void Illuminacio::keyPressEvent(QKeyEvent *)
{
	
}

void Illuminacio::mouseMoveEvent(QMouseEvent *)
{
	
}

