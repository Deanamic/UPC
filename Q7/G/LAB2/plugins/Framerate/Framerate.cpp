#include "Framerate.h"
#include "glwidget.h"

void ModelInfo2::onPluginLoad()
{
	timer.start();
}

void ModelInfo2::preFrame()
{
	++frames;
}

void ModelInfo2::postFrame()
{
    QFont font;
    font.setPixelSize(32);
    painter.begin(glwidget());
    painter.setFont(font);
    painter.setPen(QColor(0,0,0));
    int x = 15;
    int y = 40;
    QRectF Box(QPointF(x,y),QPointF(x+1000,y+1000));
    painter.drawText(Box, QString("FPS:%1\n").arg(double(1000*frames)/timer.elapsed()));    
    painter.end();
}

void ModelInfo2::onObjectAdd()
{
	
}

bool ModelInfo2::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo2::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo2::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo2::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo2::mouseMoveEvent(QMouseEvent *)
{
	
}

