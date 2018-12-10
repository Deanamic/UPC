#ifndef _ILLUMINACIO_H
#define _ILLUMINACIO_H

#include "plugin.h" 
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>

class Illuminacio: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	 void onPluginLoad();
	 void preFrame();
	 void postFrame();

	 void onObjectAdd();
	 bool drawScene();
	 bool drawObject(int);

	 bool paintGL();

	 void keyPressEvent(QKeyEvent *);
	 void mouseMoveEvent(QMouseEvent *);
	 
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs;

  private:
	// add private methods and attributes here
};

#endif
