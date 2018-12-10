#ifndef _MODELINFO2_H
#define _MODELINFO2_H

#include "plugin.h" 
#include <QPainter>
#include <QRectF>
#include <QPointF>
#include <QColor>
#include <QElapsedTimer> 
 
class ModelInfo2: public QObject, public Plugin
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
  private:
    int frames = 0;
    QElapsedTimer timer;
    QPainter painter;
	// add private methods and attributes here
};

#endif
