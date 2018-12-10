#include "showdegree.h"
#include "glwidget.h"

void Showdegree::onPluginLoad()
{
	
}

void Showdegree::preFrame()
{
	
}

void Showdegree::postFrame()
{
    int cnt = 0;
    for(int i = 0; i < scene()->objects()[0].faces().size(); ++i) {
        cnt += scene()->objects()[0].faces()[i].numVertices();
    }
    QFont font;
    font.setPixelSize(32);
    painter.begin(glwidget());
    painter.setFont(font);
    painter.setPen(QColor(0,0,0));
    int x = 15;
    int y = 40;
    QRectF Box(QPointF(x,y),QPointF(x+1000,y+1000));
    painter.drawText(Box, QString("Mean Degree:%1\n")
        .arg(double(cnt)/double(scene()->objects()[0].vertices().size())));    
    painter.end();
}

void Showdegree::onObjectAdd()
{
	
}

bool Showdegree::drawScene()
{
	return false; // return true only if implemented
}

bool Showdegree::drawObject(int)
{
	return false; // return true only if implemented
}

bool Showdegree::paintGL()
{
	return false; // return true only if implemented
}

void Showdegree::keyPressEvent(QKeyEvent *)
{
	
}

void Showdegree::mouseMoveEvent(QMouseEvent *)
{
	
}

